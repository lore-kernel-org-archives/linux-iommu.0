From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Wed, 30 Nov 2016 07:14:17 -0700
Message-ID: <20161130071417.3fc4357d@t450s.home>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
	<6c9012fd-070b-6218-48e7-69b37f2559dd@redhat.com>
	<CAFpQJXWp5BfsxU5nkWm7hrq5wp6=b-6iYVHjBQYhmkWN_kSSzg@mail.gmail.com>
	<3d0ddb50-6e63-3fe2-55c0-ce49579905c9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3d0ddb50-6e63-3fe2-55c0-ce49579905c9-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,   <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, diana.craciun-3arQi8VN3Tc@public.gmane.org,  iommu@lists., Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>,  Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,  "@mail.linuxfoundation.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, " <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,  Ganapatrao Kulkarni <gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,  christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"@mail.linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 30 Nov 2016 11:14:22 +0100
Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Ganapat,
> 
> On 30/11/2016 11:04, Ganapatrao Kulkarni wrote:
> > Hi Eric,
> > 
> > in you repo "https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3"
> > there is 11th patch "pci: Enable overrides for missing ACS capabilities"
> > is this patch part of some other series?  
> 
> Actually this is a very old patch from Alex aimed at working around lack
> of PCIe ACS support: https://lkml.org/lkml/2013/5/30/513

This patch is not destined for upstream, be very cautious relying on
it.  Hardware vendors need to be aware that lack of ACS imposes usage
restrictions.  Allowing users to arbitrarily override isolation for
various components is not supportable.  Quirks can be used to expose
isolation where it exists, but is not described by ACS.  Where
isolation does not exist, this patch is unsafe.  Thanks,

Alex
