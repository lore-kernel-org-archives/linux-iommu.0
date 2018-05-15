From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] iommu/amd: Cleanup locking in
	__attach/detach_device()
Date: Tue, 15 May 2018 16:47:11 +0200
Message-ID: <20180515144711.edh47zx4izldl3du@8bytes.org>
References: <20180507125329.24648-1-anna-maria@linutronix.de>
	<20180507125329.24648-4-anna-maria@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180507125329.24648-4-anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 07, 2018 at 02:53:28PM +0200, Anna-Maria Gleixner wrote:
> Since introduction of the pd_bitmap_lock in commit 2bc001808904
> ("iommu/amd: Split domain id out of amd_iommu_devtable_lock")
> amd_iommu_devtable_lock is only taken around __detach_device() and
> __attach_device() calls.
> 
> The lock is not protecting anything as all operations are domain specific
> and protected by domain->lock in __detach_device() and __attach_device(),
> so amd_iommu_devtable_lock has no real purpose anymore.

There is a subtle problem with this, as the lock you remove here
protects changes to the device table. Now one could argue that we never
check what we actually overwrite there, so it doesn't matter and the
lock can be removed. That is true, but it leaves an existing
race-condition in the code when a two cores try to assign the same
device to different domains.

So while at it, can you look into fixing that too before removing the
devtable_lock?


	Joerg
