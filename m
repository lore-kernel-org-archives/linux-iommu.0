From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [bug report] iommu: iommu_get_group_resv_regions
Date: Fri, 3 Feb 2017 10:47:38 +0100
Message-ID: <77520e58-f6e9-f4d5-d909-90cea7ed6bae@redhat.com>
References: <20170203091440.GA23426@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170203091440.GA23426@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Dan,

On 03/02/2017 10:14, Dan Carpenter wrote:
> Hello Eric Auger,
> 
> The patch 6c65fb318e8b: "iommu: iommu_get_group_resv_regions" from
> Jan 19, 2017, leads to the following static checker warning:
> 
> 	drivers/iommu/iommu.c:215 iommu_insert_device_resv_regions()
> 	error: uninitialized symbol 'ret'.
> 
> drivers/iommu/iommu.c
>    203  static int
>    204  iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
>    205                                   struct list_head *group_resv_regions)
>    206  {
>    207          struct iommu_resv_region *entry;
>    208          int ret;
>    209  
>    210          list_for_each_entry(entry, dev_resv_regions, list) {
>    211                  ret = iommu_insert_resv_region(entry, group_resv_regions);
>    212                  if (ret)
>    213                          break;
>    214          }
>    215          return ret;
> 
> On the one hand, it probably doesn't make sense that the dev_resv_regions
> would ever be empty, but on the other hand, there some code that assumes
> it is possible.  What I mean is that iommu_get_resv_regions() can
> basically do nothing if ->get_resv_regions() isn't implemented.
> 
> I guess we should probably set ret = -EINVAL here?

we should rather initialize ret to 0. The dev_resv_regions can be void
if a device has no reserved region or if the IOMMU does not implement
the ops. We only return -ENOMEM error if we failed allocating.

Do you want to send the fix or shall I do?

Thanks for reporting

Eric
-
> 
>    216  }
>    217  
>    218  int iommu_get_group_resv_regions(struct iommu_group *group,
>    219                                   struct list_head *head)
>    220  {
>    221          struct iommu_device *device;
>    222          int ret = 0;
>    223  
>    224          mutex_lock(&group->mutex);
>    225          list_for_each_entry(device, &group->devices, list) {
>    226                  struct list_head dev_resv_regions;
>    227  
>    228                  INIT_LIST_HEAD(&dev_resv_regions);
>    229                  iommu_get_resv_regions(device->dev, &dev_resv_regions);
>    230                  ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
>    231                  iommu_put_resv_regions(device->dev, &dev_resv_regions);
>    232                  if (ret)
>    233                          break;
>    234          }
>    235          mutex_unlock(&group->mutex);
>    236          return ret;
>    237  }
>    238  EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
> 
> 
> regards,
> dan carpenter
> 
