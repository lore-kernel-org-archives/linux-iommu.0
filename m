From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] iommu: Add event tracing feature to iommu
Date: Mon, 29 Jul 2013 18:29:28 -0700
Message-ID: <1375147768.2075.91.camel@joe-AO722>
References: <1375147366-2922-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375147366-2922-1-git-send-email-shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-07-29 at 19:22 -0600, Shuah Khan wrote:
> Add tracing feature to iommu to report various iommu events. Classes
> iommu_group, iommu_device, iommu_map_unmap, and iommu_amd_event are defined.

Hi again Shuah

> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
[]
> @@ -2159,6 +2160,15 @@ static int iommu_prepare_identity_map(struct pci_dev *pdev,
>  	printk(KERN_INFO
>  	       "IOMMU: Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
>  	       pci_name(pdev), start, end);
> +
> +	{
> +		trace_amd_event("Event", 0x1, pdev->devfn, 0, start, 2);
> +		trace_remove_device_from_group(0, &pdev->dev);
> +		trace_attach_device_to_domain(&pdev->dev);
> +		trace_detach_device_from_domain(&pdev->dev);
> +		trace_map(start, end, 1024);
> +		trace_unmap(start, end, 1024);
> +	}

Aren't these parentheses superfluous and
so the indent too deep too?
