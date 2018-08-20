From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
	into tegra20-mc
Date: Mon, 20 Aug 2018 22:27:49 +0300
Message-ID: <b46cac22-9b31-9aa7-7eca-4725156346bb@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
	<20180818155430.5586-7-digetx@gmail.com> <20180820191209.GA28618@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180820191209.GA28618@bogus>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 20.08.2018 22:12, Rob Herring wrote:
> On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
>> Splitting GART and Memory Controller wasn't a good decision that was made
>> back in the day. Given that the GART driver hasn't ever been used by
>> anything in the kernel, we decided that it will be better to correct the
>> mistakes of the past and merge two bindings into a single one. In a result
> 
> As a result...
> 
>> there is a DT ABI change for the Memory Controller that allows not to
>> break newer kernels using older DT by introducing a new required property,
>> the memory clock. Adding the new clock property also puts the tegra20-mc
>> binding in line with the bindings of the later Tegra generations.
> 
> I don't understand this part. It looks to me like you are breaking 
> compatibility. The driver failing to probe with an old DT is okay?

Yes, DT compatibility is broken. New driver won't probe/load with the old DT,
that's what we want.

> OS's like OpenSUSE use new DTs with older kernel versions, so you should 
> consider how to not break them as well. I guess if all this is optional 
> or has been unused, then there shouldn't be a problem.

That's interesting.. Memory Controller isn't optional, I guess we could change
compatible to "nvidia,tegra20-mc-gart".

Thierry, do you have any other suggestions?
