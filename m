From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Date: Tue, 28 Aug 2018 09:36:16 -0700
Message-ID: <20180828093616.30e1160f@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <b6621306-fd32-7ede-ae88-7345898eb134@redhat.com>
        <20180827221422.57e233df@jacob-builder>
        <7c331f56-1ff8-7929-76bf-e73915a91ace@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c331f56-1ff8-7929-76bf-e73915a91ace@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi L <yi.l.liu@linux.intel.com>, Raj Ashok <ashok.raj@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 28 Aug 2018 10:34:19 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> > Anyway, for the new VT-d 3.0 spec. we no longer need this API. In
> > stead, I will introduce bind_guest_pasid() API, where per device
> > PASID table is allocated by the host.  
> 
> So what is the exact state of this series? Is it outdated as you don't
> target VT-d 2.5 anymore? Will you keep the rest of the API?

Hi Eric,

I am not targeting VT-d 2.5 for SVA related work. I am working on the
rest of the APIs for supporting VT-d v3, which includes guest PASID
bind, fault reporting, and invalidation passdown from the guest. These
are based on some recent patches from Baolu.
https://lkml.org/lkml/2018/7/16/62

So I feel it is better for you to take over bind_pasid_table() API in
your series. I will drop it from my next version.

Thanks,

Jacob
