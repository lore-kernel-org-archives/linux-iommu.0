From: Yehezkel Bernat <yehezkelshb@gmail.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Date: Mon, 12 Nov 2018 18:59:02 +0200
Message-ID: <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com> <20181112160628.86620-5-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112160628.86620-5-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com, bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com, lukas@wunner.de, Christian Kellner <ckellner@redhat.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 6:06 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Recent systems shipping with Windows 10 version 1803 or later may
> support a feature called Kernel DMA protection [1]. In practice this
> means that Thunderbolt connected devices are placed behind an IOMMU
> during the whole time it is connected (including during boot) making
> Thunderbolt security levels redundant. Some of these systems still have
> Thunderbolt security level set to "user" in order to support OS
> downgrade (the older version of the OS might not support IOMMU based DMA
> protection so connecting a device still relies on user approval then).
>
> Export this information to userspace by introducing a new sysfs
> attribute (iommu_dma_protection). Based on it userspace tools can make
> more accurate decision whether or not authorize the connected device.
>
> In addition update Thunderbolt documentation regarding IOMMU based DMA
> protection.
>
> [1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

I can't comment on the IOMMU side, but the Thunderbolt side looks good to me.

Just one point:
Have you considered the option to add this property per (TBT?) device?
If the kernel may decide to enable/disable the IOMMU or AST per device, maybe
it should be on this level.
Or maybe the IOMMU decision isn't going to change (it's system-wide) and the AST
decision will be communicated per device by a new sysfs attribute anyway, if
needed?
