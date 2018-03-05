From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [bug report] iommu/arm-smmu: Make use of the iommu_register interface
Date: Mon, 5 Mar 2018 17:33:02 +0300
Message-ID: <20180305143302.GA6224@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Joerg Roedel,

This is a semi-automatic email about new static checker warnings.

The patch 9648cbc9625b: "iommu/arm-smmu: Make use of the 
iommu_register interface" from Feb 1, 2017, leads to the following 
Smatch complaint:

    ./drivers/iommu/arm-smmu-v3.c:1957 arm_smmu_remove_device()
    warn: variable dereferenced before check 'master' (see line 1956)

./drivers/iommu/arm-smmu-v3.c
  1955		master = fwspec->iommu_priv;
  1956		smmu = master->smmu;
                       ^^^^^^^^^^^^
Pach adds unchecked dereference

  1957		if (master && master->ste.assigned)
                    ^^^^^^
The old code assumes "master" can be NULL.

  1958			arm_smmu_detach_dev(dev);
  1959		iommu_group_remove_device(dev);

regards,
dan carpenter
