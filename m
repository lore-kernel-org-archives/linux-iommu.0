From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v6 1/3] iommu: Implement common IOMMU ops for DMA mapping
Date: Wed, 4 Nov 2015 09:27:48 +0000
Message-ID: <20151104092748.GI8644@n2100.arm.linux.org.uk>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<ab8e1caa40d6da1afa4a49f30242ef4e6e1f17df.1443718557.git.robin.murphy@arm.com>
	<1445867094.30736.14.camel@mhfsdcap03> <562E5AE4.9070001@arm.com>
	<CAGS+omAWCQsqk56iv0PW2ZhTJ1342GufUsJCP=VYSgCxZNLJpA@mail.gmail.com>
	<56337E4D.1010304@arm.com>
	<CAGS+omAmxbb4uVzaQh1xPmkFtcF6KP-HSV-40=sm1BRTdh+=OQ@mail.gmail.com>
	<CAAFQd5C_dkWBZrQXtyO59ARw7q-0fg-Wk98yApC5VHdQ8-AmNw@mail.gmail.com>
	<5638F1C4.3000900@arm.com>
	<CAAFQd5A4TcvkDMFezqEpkfWL+7yO2v=Hm=twk=p-NpADPpvqEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAFQd5A4TcvkDMFezqEpkfWL+7yO2v=Hm=twk=p-NpADPpvqEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Osciak <pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Bobby Batacharia (via Google Docs)" <Bobby.Batacharia-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lin PoChun <pochun.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 04, 2015 at 02:12:03PM +0900, Tomasz Figa wrote:
> My understanding of a scatterlist was that it represents a buffer as a
> whole, by joining together its physically discontinuous segments.

Correct, and it may also be scattered in CPU virtual space as well.

> I don't see how single segments (layout of which is completely up to
> the allocator; often just single pages) would be usable for hardware
> that needs to do some work more serious than just writing a byte
> stream continuously to subsequent buffers. In case of such simple
> devices you don't even need an IOMMU (for means other than protection
> and/or getting over address space limitations).

All that's required is that the addresses described in the scatterlist
are accessed as an apparently contiguous series of bytes.  They don't
have to be contiguous in any address view, provided the device access
appears to be contiguous.  How that is done is really neither here nor
there.

IOMMUs are normally there as an address translator - for example, the
underlying device may not have the capability to address a scatterlist
(eg, because it makes effectively random access) and in order to be
accessible to the device, it needs to be made contiguous in device
address space.

Another scenario is that you have more bits of physical address than
a device can generate itself for DMA purposes, and you need an IOMMU
to create a (possibly scattered) mapping in device address space
within the ability of the device to address.

The requirements here depend on the device behind the IOMMU.

> However, IMHO the most important use case of an IOMMU is to make
> buffers, which are contiguous in CPU virtual address space (VA),
> contiguous in device's address space (IOVA).

No - there is no requirement for CPU virtual contiguous buffers to also
be contiguous in the device address space.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
