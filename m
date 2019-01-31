From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
Date: Thu, 31 Jan 2019 13:48:31 -0700
Message-ID: <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
 <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-31 1:20 p.m., Dave Jiang wrote:
> Does this work when the system moves the MSI vector either via software 
> (irqbalance) or BIOS APIC programming (some modes cause round robin 
> behavior)?


I don't know how irqbalance works, and I'm not sure what you are
referring to by BIOS APIC programming, however I would expect these
things would not be a problem.

The MSI code I'm presenting here doesn't do anything crazy with the
interrupts, it allocates and uses them just as any PCI driver would. The
only real difference here is that instead of a piece of hardware sending
the IRQ TLP, it will be sent through the memory window (which, from the
OS's perspective, is just coming from an NTB hardware proxy alias).

Logan
