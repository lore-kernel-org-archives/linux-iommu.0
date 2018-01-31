From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: ARM64 SMMU Setup
Date: Wed, 31 Jan 2018 22:21:02 +0000
Message-ID: <CAKv+Gu-vwWp_o=XUd17OJ28Brh=Qt_GibpiSMByAXFW07VrxPA@mail.gmail.com>
References: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fc00c99b-7766-2ac5-83a5-2ed9e13a15e1-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 31 January 2018 at 22:09, Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi,
>
> I'm enabling the ARM SMMU-500 on an ARM64 A53. I'm hitting a data abort in
> the probe functions because I'm accessing the registers in EL1 mode.
>

Why do you think the fact that you are running at EL1 is causing the data abort?

> Linux starts in EL2 mode but drops down to EL1 mode by the time it reaches
> the arm-smmu probe function.
>
> Is there something else I need to add to either move the arm-smmu probe
> earlier or remain in EL2 until after the arm-smmu probe?
>

No. I am pretty sure EL2 vs EL1 is not causing your issue. Could you
elaborate on the nature of the exception you are getting?

> A Google search didn't turn up anything so I hoped posting to the list would
> help.
>
> Thanks in advance,
>
> Thor
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
