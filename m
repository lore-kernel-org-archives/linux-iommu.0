From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Date: Wed, 21 Mar 2018 10:32:09 -0400
Message-ID: <20180321143209.GN1110@char.us.oracle.com>
References: <20180319103826.12853-1-hch@lst.de>
	<20180319152737.GK1110@char.us.oracle.com>
	<20180319152840.GA28041@lst.de>
	<20180320083751.nrpt64dsmpqbhzc6@gmail.com>
	<20180320084412.GA16337@lst.de>
	<20180320090351.2qnwcsauhodrqxdj@gmail.com>
	<CAPbh3rspsGE3i=WzxC4DL=EDTEbhVZVb29j-fyhAXZRwk=Xncg@mail.gmail.com>
	<20180320151600.GA23920@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180320151600.GA23920-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 20, 2018 at 04:16:00PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 20, 2018 at 11:25:21AM +0000, Konrad Rzeszutek Wilk wrote:
> > Are you testing with swiotlb=force?
> 
> I've done swiotlb=force testing with earlier versions, and otherwise
> relied on a VM with more the 4gb of memory and emulated devices
> without 64-bit capability.

Awesome! I also did my testing so all good. Ingo, if you want to
you can add 'Acked-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>'
on the patches that don't have my tag.

Christoph, thank you for cleaning up this swamp!
