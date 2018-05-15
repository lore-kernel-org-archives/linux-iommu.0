From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Tue, 15 May 2018 15:46:03 +0200
Message-ID: <20180515134603.GD18595@8bytes.org>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
 <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
 <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <gary.hook@amd.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 14, 2018 at 03:00:50PM -0500, Gary R Hook wrote:
> This was brought up a few weeks ago in, I believe, version 3 of this patch.
> That question was discussed (because that's what I did the first time out),
> and _someone_ _else_ asked about why I didn't just do it the way I've done
> it here.

You don't have this problem if you put the code in amd_iommu.c in an
IOMMU_DEBUGFS ifdef.



	Joerg
