From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 5/7] iommu/amd: Implement (un)map_resource
Date: Wed, 1 Jul 2015 11:13:06 -0500
Message-ID: <20150701161306.GB13409@google.com>
References: <1432919686-32306-1-git-send-email-wdavis@nvidia.com>
 <1432919686-32306-6-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432919686-32306-6-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
To: wdavis@nvidia.com
Cc: Joerg Roedel <joro@8bytes.org>, Terence Ripperda <tripperda@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Jerome Glisse <jglisse@redhat.com>, Mark Hounschell <markh@compro.net>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Yijing Wang <wangyijing@huawei.com>, Alex Williamson <alex.williamson@redhat.com>, Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 29, 2015 at 12:14:44PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Implement 'map_resource' for the AMD IOMMU driver. Generalize the existing
> map_page implementation to operate on a physical address, and make both
> map_page and map_resource wrappers around that helper (and similiarly, for

s/similiarly/similarly/
