From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
Date: Wed, 14 Oct 2015 19:19:44 +0100
Message-ID: <561E9CC0.40701@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<561CF53E.7000809@arm.com> <20151014115013.GM27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151014115013.GM27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 14/10/15 12:50, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> Hi Robin,
>
> On Tue, Oct 13, 2015 at 01:12:46PM +0100, Robin Murphy wrote:
>> Anyway, what are your thoughts on taking this for 4.4? Since the
>> dependencies are now in and we're at -rc5 already, I'm on the verge
>> of reposting a self-contained version to go through arm64, as we
>> really need to unblock all the follow-on development there (it's a
>> shame that of the people I'm aware want this, it's only me and the
>> Mediatek/Chrome guys here on the list saying so).
>
> I plan to take it for 4.4, given the missing ack arrives. What are your
> plans to resolve the remaining issues, like with the probe deferral
> patch-set?

That's great, thanks. I've been keeping an eye on the on-demand probing 
series[0], and now that things are looking promising there I'm having a 
go at pulling it in as it lets us solve the device dependency issue in 
an even neater way than deferral. With the rest of Laurent's patches to 
move the OF dma_ops configuration into the probe path, I just need to 
finish working out how to handle probe failure/deferral, and we should 
be good to go. That's my priority for 4.5, in parallel with properly 
wiring up the ARM SMMU driver to work nicely with this stuff.

Sorting out the configuration order also gets us a lot closer to 
handling multiple IOMMU drivers for platform devices, and moving 32-bit 
ARM over to the common code - plus I now have some RK3288 hardware which 
can serve to test both of those, too.

Robin.

[0]:http://thread.gmane.org/gmane.linux.acpi.devel/78653
