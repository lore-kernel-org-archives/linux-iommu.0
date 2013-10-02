From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/6] iommu/arm-smmu: Support buggy implemenations where
	all config accesses are secure
Date: Wed, 2 Oct 2013 11:44:47 +0100
Message-ID: <20131002104447.GE28311@mudshark.cambridge.arm.com>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380631150-10783-7-git-send-email-andreas.herrmann@calxeda.com>
	<524ACE13.4020309@gmail.com> <20131001181709.GZ3315@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131001181709.GZ3315@alberich>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 01, 2013 at 07:17:09PM +0100, Andreas Herrmann wrote:
> On Tue, Oct 01, 2013 at 09:28:51AM -0400, Rob Herring wrote:
> > On 10/01/2013 07:39 AM, Andreas Herrmann wrote:
> > > In such a case we have to use secure aliases of some non-secure
> > > registers.
> > > 
> > > This behaviour is controlled via a flag in smmu->bugs. It is set
> > > based on DT information when probing an SMMU device.
> > 
> > Perhaps quirks would be a nicer word...
> 
> In fact it might be better to rename this as "options".
> For device isolation I had added a flag to indicate this in
> smmu->features.
> But it might be better to not mix hardware features with software
> features or options.

Yes, I also didn't like the mixing of hardware and software features, but I
couldn't think of a good way to separate them out. Sounds like you might be
on to something.

> So what do you (Will and Rob) think about a change like
> 
>  struct arm_smmu_device {
>    ...
> 
>  #define ARM_SMMU_FEAT_COHERENT_WALK     (1 << 0)
>  #define ARM_SMMU_FEAT_STREAM_MATCH      (1 << 1)
>  #define ARM_SMMU_FEAT_TRANS_S1          (1 << 2)
>  #define ARM_SMMU_FEAT_TRANS_S2          (1 << 3)
>  #define ARM_SMMU_FEAT_TRANS_NESTED      (1 << 4)
>          u32                             features;
> + #define ARM_SMMU_OPT_SECURE_CFG_ACCESS  (1 << 0)
> + #define ARM_SMMU_OPT_ISOLATE_DEVICES    (1 << 1)
> +        u32                             options;
>          int                             version;

I'm ok with this change, but it gets you guys off the hook with your broken
integration!

>    ...
>  }
> 
> DT property "calxeda,smmu-secure-cfg-access" would set
> ARM_SMMU_OPT_SECURE_CFG_ACCESS and
> DT property "linux,arm-smmu-isolate-devices" would set
> ARM_SMMU_OPT_ISOLATE_DEVICES.
> 
> (Maybe in future there will be more driver options. )

Yeah, and you could probably go all out with macros to generate this stuff
based on compatible string and OPT #define too.

Will
