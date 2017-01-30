From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
Date: Tue, 31 Jan 2017 07:16:23 +0900
Message-ID: <CANqRtoQGtak34vEd=aAsPaHM2o=MkZwq0WLOjiHi7fmqFnxUQg@mail.gmail.com>
References: <148517158986.13306.314435910710426381.sendpatchset@little-apple>
	<148517162908.13306.2467186615655446796.sendpatchset@little-apple>
	<20170127114724.GI27598@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170127114724.GI27598-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Fri, Jan 27, 2017 at 8:47 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Jan 23, 2017 at 08:40:29PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>
>> Bump up the maximum numbers of micro-TLBS to 48.
>>
>> Each IPMMU device instance get micro-TLB assignment via
>> the "iommus" property in DT. Older SoCs tend to use a
>> maximum number of 32 micro-TLBs per IPMMU instance however
>> newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.
>>
>> At this point no SoC specific handling is done to validate
>> the maximum number of micro-TLBs, and because of that the
>> DT information is assumed to be within correct range for
>> each particular SoC.
>>
>> If needed in the future SoC specific feature flags can be
>> added to handle the maximum number of micro-TLBs without
>> requiring DT changes, however at this point this does not
>> seem necessary.
>>
>> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>
> I get a conflict when applying this to v4.10-rc5. What is this based on,
> any patches I missed?

Thanks for giving it a go. The second patch in this series should apply as-is:
[PATCH v2 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding

However for driver code there are two series in between:
 [PATCH v6 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V6
 [PATCH v2 00/11] iommu/ipmmu-vmsa: r8a7795 support V2

For more detailed dependency information please see the cover letter!

Regarding the driver code please wait for "IPMMU multi-arch update V7"
that takes comments from Laurent into consideration. Hopefully I
should be able to send it out some time this week.

As for "[PATCH v2 1/3] iommu/ipmmu-vmsa: Add r8a7796 DT binding",
would it be possible to fast track mainline merge of that particular
DT binding patch? Can you take it in your tree?

To give some background, we already have the IPMMU DT binding for
older devices and the sister device r8a7795 in mainline, so the
r8a7796 DT binding is just a small incremental step. To make sure we
don't go too wild with DT changes we tend to require that the DT
binding change should be queued up before starting to merge changes to
DTS files. So currently some DT changes are blocking on that r8a7796
DT binding and it would be nice to unblock those if possible..

Thanks!

/ magnus
