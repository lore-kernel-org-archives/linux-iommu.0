From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 3.6-rc7 boot crash + bisection
Date: Wed, 26 Sep 2012 08:52:01 -0600
Message-ID: <1348671121.28860.186.camel@bling.home>
References: <20120924210348.5f50677b@brain.lan>
	<1348597970.28860.114.camel@bling.home>
	<20120925205420.0a07dea2@brain.lan>
	<1348602226.28860.132.camel@bling.home>
	<20120926010154.49cc2588@brain.lan>
	<20120926144345.GC10549@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120926144345.GC10549-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Roedel, Joerg" <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Florian Dazinger <florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2012-09-26 at 16:43 +0200, Roedel, Joerg wrote:
> Florian,
> 
> On Wed, Sep 26, 2012 at 01:01:54AM +0200, Florian Dazinger wrote:
> > you're right, either "amd_iommu=off" or removing the audio card makes
> > the failure disappear. I will test the new BIOS rev. tomorrow.
> 
> Can you please test this diff and report if it fixes the problem for
> you?
> 
> Thanks.
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index b64502d..e89daf1 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -266,7 +266,7 @@ static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
>  
>  static int iommu_init_device(struct device *dev)
>  {
> -	struct pci_dev *dma_pdev, *pdev = to_pci_dev(dev);
> +	struct pci_dev *dma_pdev = NULL, *pdev = to_pci_dev(dev);
>  	struct iommu_dev_data *dev_data;
>  	struct iommu_group *group;
>  	u16 alias;
> @@ -293,7 +293,9 @@ static int iommu_init_device(struct device *dev)
>  		dev_data->alias_data = alias_data;
>  
>  		dma_pdev = pci_get_bus_and_slot(alias >> 8, alias & 0xff);
> -	} else
> +	}
> +
> +	if (dma_pdev == NULL)
>  		dma_pdev = pci_dev_get(pdev);
>  
>  	/* Account for quirked devices */
> 

Assuming this works, it may be ok as a 3.7 fix, but if there was
actually more than one device behind the alias we'd expose them as
separate iommu groups.  I don't think that's what we want.  Maybe it
should at least get a pr_warn.  Thanks,

Alex
