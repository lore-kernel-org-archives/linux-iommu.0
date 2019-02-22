From: Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Fri, 22 Feb 2019 12:14:34 +0000
Message-ID: <TY2P153MB0222F0ED0743B87BB103705C927F0@TY2P153MB0222.APCP153.PROD.OUTLOOK.COM>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549894824-26623-3-git-send-email-Tianyu.Lan@microsoft.com>
 <DM5PR2101MB091885D1CD3761322191CAAFD77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR2101MB091885D1CD3761322191CAAFD77E0@DM5PR2101MB0918.namprd21.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Kelley <mikelley@microsoft.com>, "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, KY Srinivasan <kys@microsoft.com>, vkuznets <vkuznets@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Michael:
               Thanks for your review.

-----Original Message-----
From: Michael Kelley <mikelley@microsoft.com>=20
Sent: Friday, February 22, 2019 1:28 AM
To: lantianyu1986@gmail.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; joro@8bytes.org; mchehab+samsung=
@kernel.org; davem@davemloft.net; gregkh@linuxfoundation.org; nicolas.ferre=
@microchip.com; arnd@arndb.de; linux-kernel@vger.kernel.org; iommu@lists.li=
nux-foundation.org; KY Srinivasan <kys@microsoft.com>; vkuznets <vkuznets@r=
edhat.com>; alex.williamson@redhat.com; sashal@kernel.org; dan.carpenter@or=
acle.com; linux-hyperv@vger.kernel.org
Subject: RE: [PATCH V4 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, Febru=
ary 11, 2019 6:20 AM
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
> +	 * in the MADT table on Hyper-v are sorted monotonic increasingly.
> +	 * APIC ID reflects cpu topology. There maybe some APIC ID
> +	 * gaps when cpu number in a socket is not power of two. Prepare
> +	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
> +	 * into ioapic_max_cpumask if its APIC ID is less than 256.
> +	 */
> +	for (i =3D min_t(unsigned int, num_possible_cpus(), 255); i >=3D 0; i--=
)

The above isn't quite right.  For example, if num_possible_cpus() is 8, the=
n the loop will be executed 9 times, for values 8 down through 0.
It should be executed for values 7 down through 0.

Yes, fix this in the V5. Thanks.

> +		if (cpu_physical_id(i) < 256)
> +			cpumask_set_cpu(i, &ioapic_max_cpumask);
> +
> +	return 0;
> +}

Michael
