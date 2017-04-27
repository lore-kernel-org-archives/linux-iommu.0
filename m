From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
	ThunderX2 erratum #74
Date: Thu, 27 Apr 2017 18:00:31 +0100
Message-ID: <20170427170030.GF1890@arm.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
	<1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
	<20170427164237.GA7114@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170427164237.GA7114@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 27, 2017 at 05:42:37PM +0100, Mark Rutland wrote:
> On Thu, Apr 27, 2017 at 05:16:23PM +0530, Geetha sowjanya wrote:
> > +	/*
> > +	 * Override the size, for Cavium CN99xx implementations
> > +	 * which doesn't support the page 1 SMMU register space.
> > +	 */
> > +	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
> > +	if (cpu_model == MIDR_THUNDERX_99XX ||
> > +	    cpu_model == MIDR_BRCM_VULCAN)
> > +		size = SZ_64K;
> 
> If you're trying to identify an SMMU erratum, identify the SMMU, not the
> CPU it happens to be paired with this time.
> 
> There are ID registers in the SMMU you can use to do so.
> 
> NAK to using the CPU ID here.

Agreed. I had some off-list discussion with Geetha where we agreed to use
the "silicon ID", which I assumed was the SMMU IIDR register.

Will
