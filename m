From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 04 Jun 2014 16:01:15 +0200
Message-ID: <13061821.NYx1AfEhs0@wuerfel>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<20140604134400.GE28484@ulmo> <20140604135600.GD6644@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140604135600.GD6644-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wednesday 04 June 2014 14:56:01 Will Deacon wrote:
> On Wed, Jun 04, 2014 at 02:44:03PM +0100, Thierry Reding wrote:
> > On Fri, May 30, 2014 at 09:54:37PM +0200, Arnd Bergmann wrote:
> > > On Friday 30 May 2014 22:29:13 Hiroshi Doyu wrote:
> > > > The disadvantage of this is that this limits the max number of streamIDs
> > > > to support. If # of streamID is increased later more than 64, this
> > > > format cannot cover any more. You have to predict the max # of streamIDs
> > > > in advance if steamID is statically assigned.
> > > > 
> > > 
> > > Well, the iommu specific binding could allow a variable #address-cells.
> > > That way, you just need to know the number of stream IDs for that instance
> > > of the iommu.
> > 
> > That sounds fairly complicated to me. I don't see what that buys us over
> > the clarity and simplicity that the above explicit notation gives us. Is
> > it not more common for a device to have a single master rather than a
> > whole bunch of them?
> 
> I've never seen a device upstream of an ARM SMMU with a single stream-id;
> they always seem to have a whole bunch of them. Calxeda's SATA controller
> had 10 IDs, for example, and a PL330 DMA controller tends to have at least
> 3.

What are those good for? Would we just always use the first one?

	Arnd
