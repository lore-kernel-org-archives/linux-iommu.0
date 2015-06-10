From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: iommu/amd: Implement dm_region call-backs
Date: Wed, 10 Jun 2015 18:39:20 +0300
Message-ID: <20150610153920.GC10549@mwanda>
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

The patch b61238c4a5e1: "iommu/amd: Implement dm_region call-backs"
from May 28, 2015, leads to the following static checker warning:

	drivers/iommu/amd_iommu.c:3153 amd_iommu_get_dm_regions()
	error: potential null dereference 'region'.  (kzalloc returns null)

drivers/iommu/amd_iommu.c
  3138  static void amd_iommu_get_dm_regions(struct device *dev,
  3139                                       struct list_head *head)
  3140  {
  3141          struct unity_map_entry *entry;
  3142          u16 devid;
  3143  
  3144          devid = get_device_id(dev);
  3145  
  3146          list_for_each_entry(entry, &amd_iommu_unity_map, list) {
  3147                  struct iommu_dm_region *region;
  3148  
  3149                  if (devid < entry->devid_start || devid > entry->devid_end)
  3150                          continue;
  3151  
  3152                  region = kzalloc(sizeof(*region), GFP_KERNEL);

No check here.  We may not care and in that case just ignore this
email.  Or add GFP_NOFAIL to silence the warning if you want.

  3153                  region->start = entry->address_start;
  3154                  region->length = entry->address_end - entry->address_start;
  3155                  if (entry->prot & IOMMU_PROT_IR)
  3156                          region->prot |= IOMMU_READ;
  3157                  if (entry->prot & IOMMU_PROT_IW)
  3158                          region->prot |= IOMMU_WRITE;
  3159  
  3160                  list_add_tail(&region->list, head);
  3161          }
  3162  }

regards,
dan carpenter
