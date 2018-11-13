From: Yehezkel Bernat <yehezkelshb@gmail.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Date: Tue, 13 Nov 2018 13:13:31 +0200
Message-ID: <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com> <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113105558.GR2500@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>, baolu.lu@linux.intel.com, ashok.raj@intel.com, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com, lukas@wunner.de, Christian Kellner <ckellner@redhat.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> > Just one point:
> > Have you considered the option to add this property per (TBT?) device?
>
> No. ;-)
>
> You mean that one device uses security levels and another IOMMU? I don't
> think it is possible without having some sort of table in the IOMMU
> driver telling which devices it needs identity map and which not. Also
> not sure what would be the benefit?

For performance, of course. If some devices are considered safe (maybe a list
communicated by platform firmware), the kernel may decide to configure them to
passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
wrong.)


> > If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
> > it should be on this level.
> > Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
> > decision will be communicated per device by a new sysfs attribute anyway, if
> > needed?
>
> Not sure what you mean by "AST"? The IOMMU decision is pretty much
> system-wide.

Sorry, I meant ATS, Address Translation Service, mentioned in patch 3 in this
series, and possibly be enabled for some devices for performance, as mentioned
there.
So if needed, this will be another attribute, and definitely
per-device, isn't it?
