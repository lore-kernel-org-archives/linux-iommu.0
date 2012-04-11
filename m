From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Wed, 11 Apr 2012 16:49:58 +0200
Message-ID: <20120411144958.GN4296@phenom.ffwll.local>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
 <20120411124810.GK4296@phenom.ffwll.local>
 <20120411132326.GD27337@avionic-0098.adnet.avionic-design.de>
 <20120411133512.GL4296@phenom.ffwll.local>
 <20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
 <20120411143456.GM4296@phenom.ffwll.local>
 <20120411154309.1f04fb80@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120411154309.1f04fb80-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2012 at 03:43:09PM +0100, Alan Cox wrote:
> > Hm, in that case it looks like your iommu works more like the gtt on intel
> > chips 
> 
> Don't overgeneralize there - on the GMA500/600 the GTT doesn't allow CPU
> side access of the GTT map (ie you can't use it to linearise pages for
> CPU view) and the 3600 is even stranger....

Sorry, I really try to totally ignore everything related to gma500 ;-)
-Daniel
-- 
Daniel Vetter
Mail: daniel-/w4YWyX8dFk@public.gmane.org
Mobile: +41 (0)79 365 57 48
