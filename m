From: KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device
	definitions
Date: Thu, 29 Mar 2012 10:43:44 +0900
Message-ID: <CAHQjnOMPvg5en_PzrPYx4nUAuPOgxiKm8HMHWAhJ4GhJqU8jKw@mail.gmail.com>
References: <000201cd0286$2e6fbb40$8b4f31c0$%cho@samsung.com>
	<20120315111227.GA2384@amd.com> <4F61FF1D.5000502@samsung.com>
	<4F630841.2070307@linaro.org> <4F63A6F6.9050506@samsung.com>
	<20120318132746.GL26973@8bytes.org> <4F73B9A3.30605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F73B9A3.30605-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subash Patel <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Younglak Kim <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sanghyun Lee <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 29, 2012 at 10:23 AM, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Joerg Roedel wrote:
>>
>> On Fri, Mar 16, 2012 at 01:47:50PM -0700, Kukjin Kim wrote:
>>>
>>> Anyway Joerg, how do you want to handle this? Do you want to pick up
>>> 1/2/3 all of them in your tree? If so, 2nd patch should be on top of
>>> some samsung topic stuff.
>>
>>
>> Since patch 2 only applies to the Samsung tree, it is best to carry
>> this in your tree for merging. Feel free to add my Acked-by to patch 3.
>> But any further patches for the Exynos IOMMU drivers should go through
>> my tree after it is merged.
>>
>
> Hi Joerg,
>
> Now that 1st and 2nd can be applied cleanly into latest mainline. But
> unfortunately, I have no chance to send them to Linus now and I'm not sure
> you can do it during this merge window. If it is possible, please keep go=
ing
> on with my ack.
>
> KyongHo, just note, happens follwoing complaint with checkpatch, but I'm =
not
> sure this should be fixed right now. I think, if required, we can fix it
> later.
>
> ERROR: Macros with complex values should be enclosed in parenthesis
> #698: FILE: arch/arm/mach-exynos/dev-sysmmu.c:64:
>
> +#define DEFINE_SYSMMU_RESOURCE(core, mem, irq) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 DEFINE_RES_MEM_NAMED(core##_PA_SYSMMU_##mem, SZ_4K, #mem), =
=A0 =A0 =A0\
> + =A0 =A0 =A0 DEFINE_RES_IRQ_NAMED(core##_IRQ_SYSMMU_##irq##_0, #mem)
>
DEFINE_SYSMMU_RESOURCE macro defines 2 array elements. The replacement stri=
ng
must not be enclosed by parenthesis.

> ERROR: Macros with complex values should be enclosed in parenthesis
> #702: FILE: arch/arm/mach-exynos/dev-sysmmu.c:68:
>
> +#define SYSMMU_RESOURCE_DEFINE(core, ipname, mem, irq) =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 SYSMMU_RESOURCE(core, ipname) { =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DEFINE_SYSMMU_RESOURCE(core, mem, irq) =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 }
>
Ditto.

> WARNING: quoted string split across lines
> #914: FILE: arch/arm/mach-exynos/dev-sysmmu.c:259:
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:=
 Failed to add device resources
> for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "%s.%d\n", __func__,
>
It does not happened in the patch I posted and the email received also does
not have such problem. I wonder why the "pr_err(..." line is split into 2 l=
ines.

Thank you for concerning :)

KyongHo.
