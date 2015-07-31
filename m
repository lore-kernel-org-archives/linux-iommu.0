From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH char-misc-next 10/19] lib: convert iova.c into a library
Date: Thu, 30 Jul 2015 17:31:18 -0700
Message-ID: <tnm1tzj2dnp61.fsf@mic-login.pdx.intel.com>
References: <cover.1438040669.git.ashutosh.dixit@intel.com>
	<8131ebc8ecb5ef13ef0aa4c49dabe9694f0e410f.1438040669.git.ashutosh.dixit@intel.com>
	<20150728134019.7f00118543a04a53855d7ba5@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150728134019.7f00118543a04a53855d7ba5@linux-foundation.org>
	(Andrew Morton's message of "Tue, 28 Jul 2015 13:40:19 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Robin Murphy <robin.murphy@arm.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Nikhil Rao <nikhil.rao@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Harish Chegondi <harish.chegondi@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 28 2015 at 01:40:19 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 27 Jul 2015 16:57:32 -0700 Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:
>
>> From: Harish Chegondi <harish.chegondi@intel.com>
>>
>> This patch converts iova.c into a library, moving it from
>> drivers/iommu/ to lib/, and exports its virtual address allocation
>> and management functions so that other modules can reuse them.
>
> From the following emails it is unclear to me whether we'll actually
> be going ahead with this, but whatever.  It's a chance to do some code
> reading.

Thanks for the review. Either us or the IOMMU team will submit a patch
incorporating your suggestions.

Ashutosh
