From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
	table if translation pre-enabled
Date: Fri, 28 Jul 2017 19:26:59 +0800
Message-ID: <20170728112659.GT24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-11-git-send-email-bhe@redhat.com>
	<20170727155550.GO3610@suse.de> <20170728090619.GM24304@x1>
	<20170728111439.GB3431@suse.de> <20170728111553.GR24304@x1>
	<20170728111809.GC3431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170728111809.GC3431-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/28/17 at 01:18pm, Joerg Roedel wrote:
> On Fri, Jul 28, 2017 at 07:15:53PM +0800, Baoquan He wrote:
> > On 07/28/17 at 01:14pm, Joerg Roedel wrote:
> > > Yes, exactly, the first device table also needs to be allocated with
> > > GFP_DMA32 so that it ends up below 4GB.
> > 
> > Got it, will do. Thanks!
> 
> Oh, and you also need to check in the kdump kernel whether the old
> device-table is really below 4GB and abort the copy otherwise.

Ah, indeed. Will change it. Thanks.
