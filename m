From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Sat, 12 Jul 2014 07:26:39 -0400
Message-ID: <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<CAF6AEGv2P_Uq8CHgm1YdaUeMSNdH62ZwjLnT83Fr5GnxEAhTMw@mail.gmail.com>
	<20140712093917.GD18601@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140712093917.GD18601-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 12, 2014 at 5:39 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Rob,
>
> On Fri, Jul 11, 2014 at 09:55:14PM +0100, Rob Clark wrote:
>> On Fri, Jul 4, 2014 at 11:29 AM, Thierry Reding
>> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ok, so I was working through this to try to convert my
>> {qcom,msm}-iommu-v0 RFC over to using these bindings.  For background,
>> I was initially using something that looked a bit more like the
>> current arm-smmu bindings:
>>
>>         gpu {
>>             #stream-id-cells = <16>;
>>             ...
>>         };
>>
>>         gfx3d: qcom,iommu@7c00000 {
>>             compatible = "qcom,iommu-v0";
>>             ...
>>             mmu-masters =
>>                 /* gfx3d_user: */
>>                 <&gpu 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>,
>>                 /* gfx3d_priv: */
>>                 <&gpu 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31>;
>>         };
>>
>>         gfx3d1: qcom,iommu@7d00000 {
>>             compatible = "qcom,iommu-v0";
>>             ...
>>             mmu-masters =
>>                 /* gfx3d_user: */
>>                 <&gpu 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15>,
>>                 /* gfx3d_priv: */
>>                 <&gpu 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31>;
>>         };
>>
>> With my current arrangement, I have everything I need when the iommu
>> device is probed to set up each of the context banks
>>
>> This proposal inverts that relationship.  Which forces me to do a lot
>> more (including DT parsing) on device attach.  Which I'm not a huge
>> fan of.  Ie. if I even wanted to try to implement per-process
>> pagetables for gpu without completely going behind the IOMMU API's
>> back, I would want attach/detach to be as lightweight as possible.
>
> I think we'd have to walk the entire device-tree at IOMMU probe time in
> order to enumerate the masters, which sounds horrible... If we want to do
> clever SMR allocation on the ARM SMMU (as I've been discussing with Olav),
> we're going to need knowledge about *all* the valid Stream IDs in the system
> before we can program *any* translations.

I guess walking the whole tree would work.. but it really doesn't
really sound like a nice solution ;-)

also, I'm not really sure to what extent it is bad form to assume the
tree is static.

>> Was there actually a good reason for having the device link to the
>> iommu rather than the other way around?  How much would people hate it
>> if I just ignore the generic bindings and use something that works for
>> me instead.  I mean, it isn't exactly like there is going to be .dts
>> re-use across different SoC's..  and at least with current IOMMU API
>> some sort of of_get_named_iommu() API doesn't really make sense.
>
> The thing is, if you end up ignoring the generic binding then we have two
> IOMMUs using the same (ARM SMMU) binding and it begs the question as to
> which is the more generic! I know we're keen to get this merged, but merging
> something that people won't use and calling it generic doesn't seem ideal
> either. We do, however, desperately need a generic binding.

yeah, ignoring the generic binding is not my first choice.  I'd rather
have something that works well for everyone.  But I wasn't really sure
if the current proposal was arbitrary, or if there are some
conflicting requirements between different platforms.

> Turning the question around; Thierry -- what are the issue in using
> something like the ARM SMMU binding (master device IDs held in the IOMMU
> node) for the nvidia IOMMU?

+1 for doing it more like how arm-smmu is currently.. that works much
better for me :-)

BR,
-R

> Will
