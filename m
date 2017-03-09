From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 04/09] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
Date: Thu, 9 Mar 2017 12:55:02 +0900
Message-ID: <CANqRtoQsf4i8URyAYP3Rv-io8WJi_tGMOPvwfbFf4NhoZnwF=g@mail.gmail.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897092335.16106.10892669490439039957.sendpatchset@little-apple>
	<CAMuHMdVrNMY41k2arM_sZc3cWh+Ac0anRzRLuk8B3PDi8v+i2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdVrNMY41k2arM_sZc3cWh+Ac0anRzRLuk8B3PDi8v+i2g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Wed, Mar 8, 2017 at 10:52 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Hi Magnus,
>
> On Wed, Mar 8, 2017 at 12:02 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>
>> Hook up IOMMU_OF_DECLARE() support in case CONFIG_IOMMU_DMA
>> is enabled. The only current supported case for 32-bit ARM
>> is disabled, however for 64-bit ARM usage of OF is required.
>>
>> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org
>
> While I'm not such a big fan of *_OF_DECLARE() (it doesn't support deferred
> probing, which is needed for any device with dependencies, like clocks and
> power domains), what's the rationale for not using IOMMU_OF_DECLARE()
> on arm32, and thus the need for setup_done?

ARM32 could (and should) be converted over to IOMMU_OF_DECLARE(), but
it is just a matter of timing. If we try to do it before ARM32 is
converted over to CONFIG_IOMMU_DMA=y then we have to handle all the
hairy legacy implementation details of IOMMU support in case of
CONFIG_IOMMU_DMA=n _and_ deal with just moving over the init order
bits to OF. Testing and keeping all the combinations working is a lot
of work.

I prefer to kill two birds with one stone and do a larger feature jump
and move over ARM32 to same state of ARM64 (with OF init) once
CONFIG_IOMMU_DMA=y is ready for 32-bit ARM. Just changing the init
order bits to OF while keeping legacy CONFIG_IOMMU_DMA=n code is
introducing potential errors with not much upside. Unless there is
some other reason to do it that I can't see that is. =)

Cheers,

/ magnus
