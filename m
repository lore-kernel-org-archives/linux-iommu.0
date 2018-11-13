From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Date: Tue, 13 Nov 2018 13:40:20 +0200
Message-ID: <20181113114020.GV2500@lahna.fi.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
 <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com>
 <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yehezkel Bernat <yehezkelshb@gmail.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, baolu.lu@linux.intel.com, ashok.raj@intel.com, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com, lukas@wunner.de, Christian Kellner <ckellner@redhat.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 13, 2018 at 01:13:31PM +0200, Yehezkel Bernat wrote:
> On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > > Just one point:
> > > Have you considered the option to add this property per (TBT?) device?
> >
> > No. ;-)
> >
> > You mean that one device uses security levels and another IOMMU? I don't
> > think it is possible without having some sort of table in the IOMMU
> > driver telling which devices it needs identity map and which not. Also
> > not sure what would be the benefit?
> 
> For performance, of course. If some devices are considered safe (maybe a list
> communicated by platform firmware), the kernel may decide to configure them to
> passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
> wrong.)

At least I'm not aware of such an option. Windows for example enables
IOMMU for everything and I think macOS does the same. In Linux (with
these patches) we put all internal devices already passthrough mode so
things like internal graphics should not be affected. eGPUs are
different thing, though.

> > > If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
> > > it should be on this level.
> > > Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
> > > decision will be communicated per device by a new sysfs attribute anyway, if
> > > needed?
> >
> > Not sure what you mean by "AST"? The IOMMU decision is pretty much
> > system-wide.
> 
> Sorry, I meant ATS, Address Translation Service, mentioned in patch 3 in this
> series, and possibly be enabled for some devices for performance, as mentioned
> there.

Thanks for clarifying :)

> So if needed, this will be another attribute, and definitely
> per-device, isn't it?

Yes, we may want to add a way enable ATS for external devices (perhaps
global option or per-device attribute) if it turns out to cause
performance issues. However, I think it can be done later if needed. I
have not seen a single device actually supporting ATS (with the
exception of the "hacked" one in the linked thesis of patch 3/4 ;-))
