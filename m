From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
Date: Wed, 3 May 2017 10:47:18 +0100
Message-ID: <20170503094717.GC8233@arm.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
 <20170427164237.GA7114@leverpostej>
 <20170427170030.GF1890@arm.com>
 <CANHdaibvzp22XEa3NnKAKUtrHcWGc9oUcnM8KubcYCzEfOaKJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANHdaibvzp22XEa3NnKAKUtrHcWGc9oUcnM8KubcYCzEfOaKJg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha Akula <geethasowjanya.akula@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geetha sowjanya <gakula@caviumnetworks.com>, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, Linu Cherian <linu.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, Geetha <gakula@cavium.com>, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Geetha,

On Tue, May 02, 2017 at 12:01:15PM +0530, Geetha Akula wrote:
> SMMU_IIDR register is broken on T99, that the reason we are using MIDR.

Urgh, that's unfortunate. In what way is it broken?

> If using MIDR is not accepted, can we enable errata based on SMMU resource size?
> some thing like below.

No, you need to get your model number added to IORT after all if the IIDR
can't uniqely identify the part.

Sorry,

Will
