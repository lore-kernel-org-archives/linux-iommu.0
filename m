From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Thu, 17 Jan 2013 02:00:03 +0900
Message-ID: <CAHQjnOMonei8ZS+wKhv4REXq_dpXPdnGrdKEfkdJ+J7QF7kf8w@mail.gmail.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
	<20130116105327.GA16543@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130116105327.GA16543-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Hyunwoong Kim <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 16, 2013 at 7:53 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Dec 26, 2012 at 01:53:15AM +0000, Cho KyongHo wrote:
>> notice: v6 patch-set is rebased on next/iommu-exynos branch of
>> linux-samsung.git.  This patch-set does not include 2 patches (05 and 06
>> patches in v5 patch-se) because they alread exist already in the branch.
>
> Given that devicetree-discuss has been notably absent from discussion
> surrounding the proposed binding, I think that including that patch in
> linux-samsung.git and dropping it from this series is rather premature.
>
> I have comments on the binding, so I'll dig up the version you posted in v5
> and add devicetree-discuss to CC.

Thank you.

>> The current exynos-iommu(System MMU) driver does not work autonomously
>> since it is lack of support for power management of peripheral blocks.
>> For example, MFC device driver must ensure that its System MMU is disabled
>> before MFC block is power-down not to invalidate IOTLB in the System MMU
>> when I/O memory mapping is changed. Because A System MMU is resides in the
>> same H/W block, access to control registers of System MMU while the H/W
>> block is turned off must be prohibited.
>>
>> This set of changes solves the above problem with setting each System MMUs
>> as the parent of the device which owns the System MMU to recieve the
>> information when the device is turned off or turned on.
>>
>> Another big change to the driver is the support for devicetree.
>> The bindings for System MMU is described in
>> Documentation/devicetree/bindings/arm/samsung/system-mmu.txt
>
> This should probably be Documentation/devicetree/bindings/iommu/ no?

Please let me check it.

Thank you.

KyongHo.
