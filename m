From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Thu, 21 Jan 2016 23:39:58 +0100
Message-ID: <20160121223958.GL18805@8bytes.org>
References: <20160114000520.GA2449@x1.redhat.com> <5697AAD8.1000105@compro.net>
	<20160120153823.GG18805@8bytes.org>
	<20160120154658.GH18805@8bytes.org> <569FB013.4050709@compro.net>
	<20160120161904.GI18805@8bytes.org> <569FCFC8.2000606@compro.net>
	<20160120182602.GJ18805@8bytes.org> <56A0F03C.8010109@compro.net>
	<56A0F221.10502@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56A0F221.10502-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 21, 2016 at 09:58:41AM -0500, Mark Hounschell wrote:
> >Here ya go.
> >
> >150952f96941cb13371770ce0cf47906647d8bba is the first bad commit
> >commit 150952f96941cb13371770ce0cf47906647d8bba
> >Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> >Date:   Tue Oct 20 17:33:35 2015 +0200
> >
> >     iommu/amd: Do not iterate over alias-list in __[attach|detach]_device
> >
> >     The alias list is handled aleady by iommu core code. No need
> >     anymore to handle it in this part of the AMD IOMMU code
> >
> >     Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> >
> >:040000 040000 334ffdc0d7ff9389478d3ce6096eb81227d8eafc
> >cb6fce5d7e94ce3e44a6a64092ba8eb32dd0978b M      drivers
> >
> 
> FYI, this commit also had tons of IO_PAGE_FAULTS booting but
> eventually all the disks but the 2 in question actually ended up
> being mounted.

I see, thanks for your effort. I'll take a closer look and hopefully
come up with a fix for you to test.


	Joerg
