From: "Zhuo, Qiuxu" <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Does a new booting kernel by "kexec -l" need to copy IR table
	from previous kernel?
Date: Fri, 28 Apr 2017 08:17:25 +0000
Message-ID: <E6AF1AFDEA62A94A97508F458CBDD47F6EBEFF34@SHSMSX101.ccr.corp.intel.com>
References: <E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9@SHSMSX101.ccr.corp.intel.com>
	<20170427161238.GD1332@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170427161238.GD1332-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg Roedel,

> From: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org] 
> Yes, that is true. But the messages are harmless and you are safe to ignore them in your usecase. 
> We only care about the kdump case when copying the old IR and DMAR tables into the new kernel, 
> because in the  kdump case the old kernel crashed and left devices in an undefined state, so that 
> they might still send DMA and IRQ requests to the new kernel, corrupting data or causing spurious/blocked irqs. 
> Blocked IRQs or DMA requests might even break devices so that the new kernel can't initialize them anymore.
...
> That is why we want to make sure, that no spurious IRQ or DMA requests are blocked when the new
>  kernel initializes the IOMMU. In the non-kdump case we can assume that the old kernel put the devices
> into a defined state where they are not sending spurious requests.

Thanks so much for your detail and clear comments, get it now.  Send you a patch " Don't print the failure message
when booting non-kdump kernel" to make it less alarming or misleading. Please review it, thanks!

BR
qiuxu
