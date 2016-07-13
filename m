From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: IOMMU+DMAR causing NMIs-s (was: 4.7-rc6: NMI in intel_idle on HP
 Proliant G6)
Date: Wed, 13 Jul 2016 10:52:58 -0300
Message-ID: <20160713135258.GE20253@khazad-dum.debian.net>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee>
 <alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
 <5630546.0MIYeGNSYG@vostro.rjw.lan>
 <alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
 <alpine.LRH.2.20.1607130855210.11080@math.ut.ee>
 <20160713081817.GJ12639@8bytes.org>
 <alpine.LRH.2.20.1607131122010.20366@math.ut.ee>
 <20160713090332.GK12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160713090332.GK12639@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Meelis Roos <mroos@linux.ee>, iommu@lists.linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 13 Jul 2016, Joerg Roedel wrote:
> On Wed, Jul 13, 2016 at 11:31:02AM +0300, Meelis Roos wrote:
> > > > Bisecting kernel configs shows that it's DMAR+IOMMU. When it is 
> > > > activated, there is high probability of NMI-s in random places.
> > > 
> > > Hmm, strange. But nothing could really surprise when you have an HP
> > > BIOS.
> > 
> > BIOS P64 01/22/2015. There seems to be a newer 2015.08.16 BIOS out but 
> > the release notes only describe updated CPU microcode for security 
> > reasons.
> 
> It is probably something HP is selling as a "feature" and not a BIOS
> bug.

Well, based on the date, it should be the microcode-level fix for this:
https://www.blackhat.com/docs/us-15/materials/us-15-Domas-The-Memory-Sinkhole-Unleashing-An-x86-Design-Flaw-Allowing-Universal-Privilege-Escalation-wp.pdf

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
