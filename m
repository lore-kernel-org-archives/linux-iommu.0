From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Thu, 22 Nov 2018 02:59:34 -0800
Message-ID: <20181122105934.GA13325@infradead.org>
References: <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
 <20181116091804.GA4548@infradead.org>
 <20181116093210.GK4179@lahna.fi.intel.com>
 <20181122104840.GO4179@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122104840.GO4179@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Yehezkel Bernat <yehezkelshb@gmail.com>, ashok.raj@intel.com, Mario Limonciello <Mario.Limonciello@dell.com>, michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>, rjw@rjwysocki.net, Anthony Wong <anthony.wong@canonical.com>, LKML <linux-kernel@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, iommu@lists.linux-foundation.org, lukas@wunner.de, jacob.jun.pan@intel.com, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 12:48:40PM +0200, Mika Westerberg wrote:
> We had an internal discussion regarding this and it was suggested that
> the new flag is called "is_untrusted" instead of "is_external". This
> covers Thunderbolt devices currently but can be extend to any other PCIe
> device such as "SD express" ones. When IOMMU is turned on it will then
> make sure devices with "is_untrusted" set are always using full IOMMU
> protection.
> 
> Any comments, objections? I was going to send v2 with this change
> included.

Sounds good to me as long as it goes along with a nice fat comment
explaining it.
