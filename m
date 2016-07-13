From: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Subject: Re: IOMMU+DMAR causing NMIs-s (was: 4.7-rc6: NMI in intel_idle on
	HP Proliant G6)
Date: Wed, 13 Jul 2016 11:31:02 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1607131122010.20366@math.ut.ee>
References: <alpine.LRH.2.20.1607121445020.2088@math.ut.ee>
	<alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
	<5630546.0MIYeGNSYG@vostro.rjw.lan>
	<alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
	<alpine.LRH.2.20.1607130855210.11080@math.ut.ee>
	<20160713081817.GJ12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160713081817.GJ12639-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> > Bisecting kernel configs shows that it's DMAR+IOMMU. When it is 
> > activated, there is high probability of NMI-s in random places.
> 
> Hmm, strange. But nothing could really surprise when you have an HP
> BIOS.

BIOS P64 01/22/2015. There seems to be a newer 2015.08.16 BIOS out but 
the release notes only describe updated CPU microcode for security 
reasons.
 
> Can you probably use the faulty config and bisect this down to a
> specific commit? In v4.7-rc1 some changes to the iova-allocation code
> got merged, but I have no idea how those could cause NMIs.

Will try but I do not know a working base yet - this was broken in both 
4.6 and 4.7-rc.

-- 
Meelis Roos (mroos-Y27EyoLml9s@public.gmane.org)
