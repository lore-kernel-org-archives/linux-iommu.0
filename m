From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: pata-macio WARNING at dmam_alloc_coherent+0xec/0x110
Date: Tue, 13 Feb 2018 02:45:46 +0100
Message-ID: <20180213014546.GB3303@lst.de>
References: <alpine.LRH.2.21.1802122246230.9153@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1802122246230.9153-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 12, 2018 at 10:52:46PM +0200, Meelis Roos wrote:
> I tested 4.16-rc1 on my PowerMac G4 and got the following warning from 
> macio pata driver. Since pata-macio has no recent changes, dma-mapping.h 
> changes seem to be related.

Thje are, as they add just that warning.  But the root cause looks
older, and that is that the macio bus doesn't seem to to set the
dma coherent mask, which could cause all kinds of hidden issues.

I'm travelling right now, but unless someone beats me to it I'll look
into a patch to properly set the coherent mask ASAP.
