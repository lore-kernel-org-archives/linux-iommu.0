From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Subject: Re: [PATCH] iommu-common: fix return type of iommu_tbl_range_alloc()
Date: Wed, 21 Oct 2015 15:56:40 -0400
Message-ID: <20151021195640.GC14667@oracle.com>
References: <55FBD36C.5070301@arm.com>
 <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
 <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
Sender: sparclinux-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Joerg Roedel <joro@8bytes.org>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On (10/21/15 21:12), Geert Uytterhoeven wrote:
> 
> Does this function really need to return DMA_ERROR_CODE in case of
> failure?

fwiw, this came up very early in code review:

  http://marc.info/?l=linux-sparc&m=142613044704833&w=2

--Sowmini
