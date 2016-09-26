From: Iago Abal <mail-nS/Qcn0WMKPsq35pWSNszA@public.gmane.org>
Subject: Potential double spin_lock_irqsave BUG in Linux 4.7's
	drivers/iommu/intel-iommu.c
Date: Mon, 26 Sep 2016 12:27:48 +0200
Message-ID: <CAGbDTvq9JPHEWR10giNwJK=6_PjyNFwjdR3KZ-gb3USDYjo_EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Using a static bug finder (EBA - https://github.com/models-team/eba) I
may have found a double spin_lock_irqsave bug in Linux 4.7's
drivers/iommu/intel-iommu.c.

The forward trace is as follows:

1. Starting in function `disable_dmar_iommu' defined at 1706;
   (see https://github.com/torvalds/linux/blob/v4.7/drivers/iommu/intel-iommu.c#L1706)
2. the lock `device_domain_lock' is first taken in line 1714:

       spin_lock_irqsave(&device_domain_lock, flags);

3. enter the `list_for_each_entry_safe' loop at 1715;
4. call function `dmar_remove_one_dev_info' (defined at 4850) in line 1726;
   (see https://github.com/torvalds/linux/blob/v4.7/drivers/iommu/intel-iommu.c#L4850)
5. finally, the lock is taken a second time in line 4856:

       spin_lock_irqsave(&device_domain_lock, flags);

If that's a bug then I am willing to help with a patch.

Thank you for your time,

Iago
