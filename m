From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 11:18:19 +0000
Message-ID: <201204121118.19685.arnd@arndb.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <20120412071816.GA18252@avionic-0098.mockup.avionic-design.de> <025f01cd1887$da56b6e0$8f0424a0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <025f01cd1887$da56b6e0$8f0424a0$%szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Thierry Reding' <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, 'Daniel Vetter' <daniel-/w4YWyX8dFk@public.gmane.org>, 'Joerg Roedel' <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, 'Jon Mayo' <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Colin Cross' <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Hiroshi Doyu' <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomasz Stanislawski <t.stanislaws-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thursday 12 April 2012, Marek Szyprowski wrote:
> Scatter lists were initially designed for the disk based block io operations, 
> hence the presence of the in-page offsets and lengths for each chunk. For 
> multimedia use cases providing an array of struct pages and asking dma-mapping 
> to map them into contiguous memory is probably all we need. I wonder if 
> introducing such new calls is a good idea. Anrd, what do think? It will 
> definitely simplify the drivers and improve the code understanding. On the 
> other hand it requires a significant amount of work in the dma-mapping 
> framework for all architectures, but that's not a big issue for me.

My feeling is that it's too much like the existing _sg version, so I wouldn't
add yet another variant. While having a simple page array is definitely
simpler and potentially faster, I think the API is already too complex
and we need to be very careful with new additions.

	Arnd
