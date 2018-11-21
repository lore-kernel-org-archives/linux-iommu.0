From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Date: Wed, 21 Nov 2018 00:45:29 -0800
Message-ID: <20181121084529.GA21766@infradead.org>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
 <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
 <7bfc2f2b-10e6-b53c-51f3-c6494b686aa3@nvidia.com>
 <25b9a20f-06b5-57ac-81f1-fd933845c77f@linux.intel.com>
 <20181116085714.GA13181@infradead.org>
 <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 02:22:08AM +0530, Kirti Wankhede wrote:
> It is about how mdev framework can be used by existing drivers. These
> symbols doesn't use any other exported symbols.

That is an unfortunate accident of history, but doesn't extent to new
ones.  It also is another inidicator those drivers probably are derived
works of the Linux kernel and might be in legal trouble one way or
another.
