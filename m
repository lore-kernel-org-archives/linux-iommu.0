From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH 09/16] iommu/amd: Add IOAPIC remapping routines
Date: Mon, 1 Oct 2012 12:34:56 -0400
Message-ID: <CACJDEmqpE_ewzZPuS9OUCOmEHS2HRL66bk0nuTOLd1aMjNu4MQ@mail.gmail.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-10-git-send-email-joerg.roedel@amd.com>
	<6d716497-bcf6-4d71-88a3-6ec772a4d396@sausexedgep01.amd.com>
	<20121001084051.GO4009@amd.com>
	<20121001134753.GF4099@phenom.dumpdata.com>
	<20121001163338.GP4009@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121001163338.GP4009@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

>> I was thinking the other way around. You recover the old affinity. Should
>> you print out a warning mentioning to the system admin that you could not
>> set the new affinity but reverted to the old one? Or will that not serve
>> anything except spam the kernel logs?
>
> Well, I don't think it makes sense to print an additional error at this
> point. The error will be propagated upwards in the call-chain and in the
> end it is up to the initiator how to handle this situation (for example
> just return a failure to user-space).

OK. Thx for the explanation. I was not sure whether the error would
propagate properly up the chain.
