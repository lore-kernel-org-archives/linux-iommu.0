From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: respect max guest address width in agaw
Date: Wed, 7 Nov 2018 14:12:25 -0800
Message-ID: <20181107141225.2339ca4f@jacob-builder>
References: <1541544435-52624-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20181107160428.awgpvo73mp3lbdro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107160428.awgpvo73mp3lbdro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, Ashok Raj <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Wed, 7 Nov 2018 17:04:28 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Tue, Nov 06, 2018 at 02:47:15PM -0800, Jacob Pan wrote:
> >  drivers/iommu/intel-iommu.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)  
> 
> Applied, thanks.

Hi Joerg,
We have found some issues with this patch on some platforms. Please
disregard this patch.

The intent of this patch was to fix some IOMMU with max address of 48
but SAGAW of both 48 and 57 bits. Need to do more investigation in the
page table level calculation and context address width setup. Sorry
about that.

Jacob
