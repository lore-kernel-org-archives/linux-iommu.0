From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] Fix bug in iommu_context_addr: Always get pointer to
 lower extended-context-table
Date: Tue, 25 Aug 2015 11:42:49 +0200
Message-ID: <20150825094249.GE32055@8bytes.org>
References: <F9D82F0D71C0024FA18FE771EDDAF149081FAC8F@G4W3303.americas.hpqcorp.net>
 <20150825084208.GB32055@8bytes.org>
 <F9D82F0D71C0024FA18FE771EDDAF149082020ED@G4W3298.americas.hpqcorp.net>
 <20150825085937.GD32055@8bytes.org>
 <F9D82F0D71C0024FA18FE771EDDAF14908203155@G4W3298.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F9D82F0D71C0024FA18FE771EDDAF14908203155@G4W3298.americas.hpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Xiao, Nan (Nan@HPservers-Core-OE-PSC)" <nan.xiao@hp.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 25, 2015 at 09:15:39AM +0000, Xiao, Nan (Nan@HPservers-Core-OE-PSC) wrote:
> In commit message:
> 
> > There is a bug in iommu_context_addr() which will always use the lower context table, event when the upper context table needs to be used. Fix this issue.
> 
> I think it should be " even when the upper context table ", not "event".

Right, fixed that. Thanks for noticing.


	Joerg
