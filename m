From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V6 2/3] IOMMU/Hyper-V: Add Hyper-V stub IOMMU driver
Date: Wed, 27 Feb 2019 17:31:38 +0000
Message-ID: <DM5PR2101MB0918BCF506C61269BE66B5BDD7740@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1551279245-25888-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551279245-25888-3-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>, "joro@8bytes.org" <joro@8bytes.org>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "arnd@arndb.de" <arnd@arndb.de>, KY Srinivasan <kys@microsoft.com>, vkuznets <vkuznets@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Wednesday, Fe=
bruary 27, 2019 6:54 AM
>=20
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
>=20
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2API=
C
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
>=20
> Define 24 IO-APIC remapping entries because Hyper-V only expose one
> single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
> https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>

Reconfirming my reviewed-by after the change to fix the
compile error detected by the kbuild test robot.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
