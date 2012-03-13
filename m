From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH v11 3/3] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Wed, 14 Mar 2012 01:38:05 +0900
Message-ID: <CAHQjnOO2Me5C6it=M0OFKdRcK0LObDR8+hPGyuUb21oqGwsg0g@mail.gmail.com>
References: <017a01ccfdee$4e5e7a00$eb1b6e00$%cho@samsung.com>
	<20120312150156.GF18973@amd.com>
	<CAHQjnOOCQb4G1aeFB0FQVBstXpaXmahnQO8+FoinPcQNZEieGg@mail.gmail.com>
	<20120313100024.GG18973@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120313100024.GG18973@amd.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Younglak Kim <younglak1004.kim@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sanghyun Lee <sanghyun75.lee@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 13, 2012 at 7:00 PM, Joerg Roedel <joerg.roedel@amd.com> wr=
ote:
> On Tue, Mar 13, 2012 at 05:50:16PM +0900, KyongHo Cho wrote:
>> >> +struct sysmmu_drvdata {
>> >> + =A0 =A0 struct device *sysmmu;
>> >> + =A0 =A0 char *dbgname;
>> >> + =A0 =A0 int nsfrs;
>> >> + =A0 =A0 void __iomem **sfrbases;
>> >> + =A0 =A0 struct clk *clk[2];
>> >> + =A0 =A0 int activations;
>> >> + =A0 =A0 rwlock_t lock;
>> >> + =A0 =A0 struct iommu_domain *domain;
>> >> + =A0 =A0 sysmmu_fault_handler_t fault_handler;
>> >> + =A0 =A0 unsigned long pgtable;
>> >> + =A0 =A0 struct iommu_client client;
>> >> +};
>> >
>> > Is there any reason why 'struct iommu_client' is a seperate data
>> > structure? Otherwise it can be merged with 'truct sysmmu_drvdata'.
>
> Of course this doesn't need to be changed immediatly. I just asked if
> there was a specific reason for this seperation.
>
>> The problems will be soon fixed and I will post next patch tomorrow.
>
> Fine. Please also get the Acked-bys from the Exynos maintainer on
> patches 1 and 2 at least. I'll merge it then.
>
Thank you.
AFAIK, Exynos maintainer is somewhat busy for his own job.
I will ask him to ack my patch soon.

Best regards,

Cho KyongHo.
