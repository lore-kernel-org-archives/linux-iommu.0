From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 10/12] NTB: Introduce NTB MSI Test Client
Date: Wed, 6 Mar 2019 14:39:32 -0700
Message-ID: <284dae8b-4e8a-1d7b-e806-bf7fed2a39a7@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-11-logang@deltatee.com>
 <20190306204400.hzpizimya7fq6swi@mobilestation>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306204400.hzpizimya7fq6swi@mobilestation>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Eric Pilmore <epilmore@gigaio.com>
List-Id: iommu@lists.linux-foundation.org



On 2019-03-06 1:44 p.m., Serge Semin wrote:
> Alas the test driver is not going to work with IDT NTB hardware,
> since it uses Spad only, which aren't supported by IDT devices. IDT NTB
> PCIe functions provide message registers to communicate with peers. See
> ntb_perf driver code for reference of portable driver design.
> 
> In order to make the test driver portable the following alterations
> are needed:
> 1) Add NTB Message register API usage together with Scratchpad+Doorbell.
> 2) When NTB MSI library is updated with functions like
> ntb_msi_peer_setup_mws()/ntb_msi_peer_clear_mws() they are needed to be
> utilized in the test driver as well to set a translation address on the
> peer side.

Per, the discussion on the previous email, we can update this later once
we actually have sensible infrastructure for it. The mess in ntb_perf is
not something I want to replicate and we don't have any interest in
creating a large amount of infrastructure to support hardware we don't
care about.

Logan
