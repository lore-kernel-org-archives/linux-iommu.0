From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v6 1/3] iommu: Implement common IOMMU ops for DMA mapping
Date: Wed, 4 Nov 2015 09:10:00 +0000
Message-ID: <20151104091000.GH8644@n2100.arm.linux.org.uk>
References: <ab8e1caa40d6da1afa4a49f30242ef4e6e1f17df.1443718557.git.robin.murphy@arm.com>
	<1445867094.30736.14.camel@mhfsdcap03> <562E5AE4.9070001@arm.com>
	<CAGS+omAWCQsqk56iv0PW2ZhTJ1342GufUsJCP=VYSgCxZNLJpA@mail.gmail.com>
	<56337E4D.1010304@arm.com>
	<CAGS+omAmxbb4uVzaQh1xPmkFtcF6KP-HSV-40=sm1BRTdh+=OQ@mail.gmail.com>
	<CAAFQd5C_dkWBZrQXtyO59ARw7q-0fg-Wk98yApC5VHdQ8-AmNw@mail.gmail.com>
	<5638F1C4.3000900@arm.com>
	<20151103184019.GD8644@n2100.arm.linux.org.uk>
	<CAAFQd5COY-dvBE73R=sUWoGfXR9CvgurGchYgXB6y9eqQ=BBUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAFQd5COY-dvBE73R=sUWoGfXR9CvgurGchYgXB6y9eqQ=BBUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Pawel Osciak <pawel-FA/gS7QP4orQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Bobby Batacharia (via Google Docs)" <Bobby.Batacharia-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lin PoChun <pochun.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 04, 2015 at 02:15:41PM +0900, Tomasz Figa wrote:
> On Wed, Nov 4, 2015 at 3:40 AM, Russell King - ARM Linux
> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > On Tue, Nov 03, 2015 at 05:41:24PM +0000, Robin Murphy wrote:
> >> Hi Tomasz,
> >>
> >> On 02/11/15 13:43, Tomasz Figa wrote:
> >> >Agreed. The dma_map_*() API is not guaranteed to return a single
> >> >contiguous part of virtual address space for any given SG list.
> >> >However it was understood to be able to map buffers contiguously
> >> >mappable by the CPU into a single segment and users,
> >> >videobuf2-dma-contig in particular, relied on this.
> >>
> >> I don't follow that - _any_ buffer made of page-sized chunks is going to be
> >> mappable contiguously by the CPU; it's clearly impossible for the streaming
> >> DMA API itself to offer such a guarantee, because it's entirely orthogonal
> >> to the presence or otherwise of an IOMMU.
> >
> > Tomasz's use of "virtual address space" above in combination with the
> > DMA API is really confusing.
> 
> I suppose I must have mistakenly use "virtual address space" somewhere
> instead of "IO virtual address space". I'm sorry for causing
> confusion.
> 
> The thing being discussed here is mapping of buffers described by
> scatterlists into IO virtual address space, i.e. the operation
> happening when dma_map_sg() is called for an IOMMU-enabled device.

... and there, it's perfectly legal for an IOMMU to merge all entries
in a scatterlist into one mapping - so dma_map_sg() would return 1.

What that means is that the scatterlist contains the original number of
entries which describes the CPU view of the buffer list using the original
number of entries, and the DMA device view of the same but using just the
first entry.

In other words, if you're walking a scatterlist, and doing a mixture of
DMA and PIO, you can't assume that if you're at scatterlist entry N for
DMA, you can switch to PIO for entry N and you'll write to the same
memory.  (I know that there's badly written drivers in the kernel which
unfortunately do make this assumption, and if they're used in the
presence of an IOMMU, they _will_ be silently data corrupting.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
