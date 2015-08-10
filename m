From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 07/12] pci: expose pci_find_host_bridge()
Date: Mon, 10 Aug 2015 12:08:57 -0500
Message-ID: <20150810170857.GC32452@google.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
 <1437601197-6481-8-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437601197-6481-8-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
To: Will Davis <wdavis@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Konrad Wilk <konrad.wilk@oracle.com>, Mark Hounschell <markh@compro.net>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Terence Ripperda <tripperda@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 22, 2015 at 04:39:52PM -0500, Will Davis wrote:
> This function takes a struct pci_bus * and returns the associated struct
> pci_host_bridge * upstream.

Nits: for the PCI parts, please run "git log --oneline" and make yours
match the style of the previous history.  Same for the changelog text
itself, which can be an imperative sentence, e.g., something like:

  Return the struct pci_host_bridge corresponding to the given pci_bus.

Text like "This function ..." or "This patch ..." is superfluous because we
already know the changelog applies to *this* patch.

Bjorn
