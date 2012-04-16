From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Mon, 16 Apr 2012 12:57:04 -0600
Message-ID: <4F8C6B80.4000001@wwwdotorg.org>
References: <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
	<4F86F97C.8010508@wwwdotorg.org>
	<20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
	<4F8753A0.6040907@wwwdotorg.org>
	<20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
	<4F887C54.6030306@wwwdotorg.org>
	<20120415083905.GA15207@avionic-0098.mockup.avionic-design.de>
	<4F8C423B.8050609@wwwdotorg.org>
	<20120416184819.GA21043@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120416184819.GA21043-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/16/2012 12:48 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
...
>>> Has there been any discussion as to how EDID data would best be represented
>>> in DT? Should it just be a binary blob or rather some textual representation?
>>
>> I think a binary blob makes sense - that's the exact same format it'd
>> have if read over the DDC I2C bus.
> 
> DTC has /incbin/ for that. Is arch/arm/boot/dts still the correct place for
> EDID blobs? I could add tegra-medcom.edid if that's okay.

As far as I know, yes.

Perhaps we'll want to start putting stuff in SoC-specific
sub-directories given the number of files we'll end up with here
(irrespective of EDID etc.), but I haven't seen any move towards that yet.
