From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix unity mapping initialization race
Date: Mon, 11 Jul 2016 09:19:59 +0200
Message-ID: <20160711071959.GB12639@8bytes.org>
References: <1467820838-5059-1-git-send-email-joro@8bytes.org>
	<57823445.1020808@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57823445.1020808-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Jul 10, 2016 at 07:40:53PM +0800, Wan Zongshun wrote:
> Do you mean we need enable the V and TV bits to DTE entry after all
> DTEs tables were initialized completely?

Yes, this is what my patch does and what fixes the bug that was
reported on machines which have unity-mapping entries.

> I checked this function 'init_device_table_dma', and find it just set
> V and TV bit, to set translation info valid and DTE bits127:1 valid.

Right, if no other bits are set this blocks all DMA from the gives
device-id.

> So I just think all things it should to do are to allow DMA access,
> GPA-to-SPA translation should be active, why you add function
> comments below is to not allow DMA access and suppress all page
> faults?
> 
> /*
>  * Init the device table to not allow DMA access for devices and
>  * suppress all page faults
>  */

Yeah, that comment needs to be updated. Not all DMA is blocked and
page-faults are not suppressed at all. Thanks for noticing.



	Joerg
