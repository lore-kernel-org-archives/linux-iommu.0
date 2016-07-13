From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: IOMMU+DMAR causing NMIs-s (was: 4.7-rc6: NMI in intel_idle on HP
	Proliant G6)
Date: Wed, 13 Jul 2016 11:43:03 +0200
Message-ID: <20160713094303.GL12639@8bytes.org>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee>
	<alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
	<5630546.0MIYeGNSYG@vostro.rjw.lan>
	<alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
	<alpine.LRH.2.20.1607130855210.11080@math.ut.ee>
	<20160713081817.GJ12639@8bytes.org>
	<alpine.LRH.2.20.1607131122010.20366@math.ut.ee>
	<20160713090332.GK12639@8bytes.org>
	<alpine.LRH.2.20.1607131206430.20366@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1607131206430.20366-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 13, 2016 at 12:16:46PM +0300, Meelis Roos wrote:
> ROM setup settings that might be of interest:
> 
> Advanced memory protection: advanced ecc support
> No-Execute memory protection: enabled
> Intel virtualization technology: enabled
> Intel hyperthreading options: enabled
> Processor core disable: all cored enabled
> Intel turbo boost technology: enabled
> Intel VT-d: enabled
> HP power profile: custom
> HP power regulator: hp dynamic power savings mode (not OS control)
> Intel qpi link power management: enabled
> Minimum processor idle power core state: C6
> Minimum processor idle power package state: C6
> Dynamic power saving mode response: fast
> Collaborative power control: enabled
> MPS table: full table apic
> NMI debug button: enabled
> PCI bus padding options: enabled
> HW prefetcher: enabled
> Adjacent sector prefetch: enabled
> Node interleaving: disabled

AFAICT these settings look normal.

> Nothing in ILO log or integrated management log (IML).

Then I think we need a bisect to make progress here.


	Joerg
