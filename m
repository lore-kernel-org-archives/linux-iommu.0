From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Fri, 10 Aug 2018 10:24:54 -0600
Message-ID: <672079e5-7432-fcd8-d81c-6d7010b71630@deltatee.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<95e53520-b05f-4be4-e694-463d717453a8@gigaio.com>
	<cdd9245f-eb23-9e10-1755-8f396a2cd255@deltatee.com>
	<b278c1e5-6f08-c879-a27d-7fc172645fd5@gigaio.com>
	<f04fae39-645e-3c6e-07c0-b194260bf5de@deltatee.com>
	<3f503940-db6a-ec75-ed15-1db99d5d48ef@gigaio.com>
	<112A412BB11A1242B37129D931BCE5348382CFB2@fmsmsx117.amr.corp.intel.com>
	<b8af340c-d40b-cb8c-987f-b394f1d6ec3e@gigaio.com>
	<adf51c74-36fa-b61d-8497-27bd75178ba4@deltatee.com>
	<aa9c3f41-efc9-8c68-a517-2736c8986621@gigaio.com>
	<1170c096-a749-6ee3-32d4-ebba1d12adff@gigaio.com>
	<c8dd4740-f01a-372f-2990-2e1163f94042@gigaio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c8dd4740-f01a-372f-2990-2e1163f94042-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, "Jiang, Dave" <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 10/08/18 10:23 AM, Kit Chow wrote:
> There is an internal routine (__intel_map_single) inside the intel iommu 
> code that does the actual mapping using a phys_addr_t. Think I'll try to 
> implement a intel_map_resource routine that calls that routine directly 
> without all of the conversions done for dma_map_{single,page} (pci bar 
> addr -> page -> phys_addr)...

Nice, yes, that was what I was thinking.

Logan
