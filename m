From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
Date: Wed, 28 Nov 2018 13:39:52 +0200
Message-ID: <20181128113952.GX2296@lahna.fi.intel.com>
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
 <20181128105415.GV2296@lahna.fi.intel.com>
 <CAJZ5v0g5h42G-Svc_DZafucb0SyNQGE2ZhnnKnJ5UTjCWCMgxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g5h42G-Svc_DZafucb0SyNQGE2ZhnnKnJ5UTjCWCMgxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com, Mario Limonciello <Mario.Limonciello@dell.com>, Anthony Wong <anthony.wong@canonical.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Christoph Hellwig <hch@infradead.org>, Alex Williamson <alex.williamson@redhat.com>ACPI Devel Maling List <li>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 28, 2018 at 12:24:27PM +0100, Rafael J. Wysocki wrote:
> I'm not sure if this is worth the extra complexity either, which is
> why I have no strong opinion here. :-)
> 
> Maybe you can add a comment, next to the prp_guids[] definition, to
> explain that the GUIDs are made equivalent to each other in order to
> avoid extra complexity in the properties handling code, with the
> caveat that the kernel will accept certain combinations of GUIDs and
> properties that are not defined strictly speaking without warning, but
> those combinations of GUIDs and properties are not expected to be used
> by firmware and they should be caught by firmware validation tools and
> reported as errors anyway.

Sure, I'll add the comment in the next version of the series.
