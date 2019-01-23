From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Date: Wed, 23 Jan 2019 08:56:58 +0100
Message-ID: <20190123075658.GE32526@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
 <20190122104454.nke2knuyqiswfh5w@8bytes.org>
 <e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

On Tue, Jan 22, 2019 at 03:53:18PM +0000, Suthikulpanit, Suravee wrote:
> Thanks for the detail. Alright then, let's just go with the version you
> sent on 1/16/19. Do you want me to resend V3 with that changes, or
> would you be taking care of that?

Please send me a v3 based on the diff I sent last week. Also add a
separate patch which adds the missing dte flush for the alias entry.

Thanks,

	Joerg
