From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Date: Tue, 11 Apr 2017 11:43:07 -0400
Message-ID: <bc0450db-5375-9774-b6e4-bcda18592d05@redhat.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
 <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
 <20170411012847.GA15291@bhelgaas-glaptop.roam.corp.google.com>
 <20170411071047.GA3610@localhost>
 <20170411134125.GA31773@bhelgaas-glaptop.roam.corp.google.com>
 <20170411152702.GA2910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170411152702.GA2910@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Jayachandran C <jnair@caviumnetworks.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

On 04/11/2017 11:27 AM, Jayachandran C wrote:
> On Tue, Apr 11, 2017 at 08:41:25AM -0500, Bjorn Helgaas wrote:

>> I suspect the reason this patch makes a difference is because the
>> current pci_for_each_dma_alias() believes one of those top-level
>> bridges is an alias, and the iterator produces it last, so that's the
>> one you map.  The IOMMU is attached lower down, so that top-level
>> bridge is not in fact an alias, but since you only look at the *last*
>> one, you don't map the correct aliases from lower down in the tree.
> 
> Exactly. The IORT spec allows a range of RIDs to map to an SMMU, which
> means that a PCI RC can multiple SMMUs, each handling a subset of RIDs.
> 
> In the case of Cavium ThunderX2, the RID which we should see on the RC
> - if we follow the standard and factor in the aliasing introduced by the
> PCI bridge and the PCI/PCIe bridge - is not the RID seen by the SMMU (or
> ITS).
> 
> But, if we stop the traversal at the point where SMMU (or ITS) is
> attached, we will get the correct RID as seen by these.

Side note that I am trying to get various specifications clarified to
promote more of a familiar alternative architecture (x86) approach in
the future in which these aren't at different levels in the topology.
But to do that requires integrated Root Complex IP with bells/whistles.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
