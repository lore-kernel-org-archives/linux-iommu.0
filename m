From: Casey Leedom <leedom@chelsio.com>
Subject: Re: DMA error when sg->offset value is greater than PAGE_SIZE in
 Intel IOMMU
Date: Mon, 25 Sep 2017 18:46:19 +0000
Message-ID: <MWHPR12MB16004E2A92CC3FFEC6313DDBC87A0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <20170920080151.GA3348@gondor.apana.org.au>
 <26992a1e-edb3-ed78-ce8e-31e0739d75f4@arm.com>
 <MWHPR12MB160092A868C613FF64CA9EE9C87A0@MWHPR12MB1600.namprd12.prod.outlook.com>,<20170925155430.GB131920@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20170925155430.GB131920@otc-nc-03>
Content-Language: en-US
Sender: linux-crypto-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Herbert Xu <herbert@gondor.apana.org.au>, Harsh Jain <Harsh@chelsio.com>, David Woodhouse <David.Woodhouse@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

| From: Raj, Ashok <ashok.raj@intel.com>
| Sent: Monday, September 25, 2017 8:54 AM
|
| Not sure how the page->offset would end up being greater than page-size?
|
| If you have additional traces, please send them by.
|
| Is this a new driver? wondering how we didn't run into this?

  According to Herbert Xu and one of our own engineers, it's actually legal
for Scatter/Gather Lists to have this.  This isn't my area of expertise
though so I'm just passing that on.

  I've asked our team to produce a detailed trace of the exact
Scatter/Gather Lists they're seeing and what ends up coming out of the DMA
Mappings, etc.  They're in India, so I expect that they'll have this for yo=
u
by tomorrow morning.

Casey
