From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv5 1/9] of: introduce
	of_property_for_earch_phandle_with_args()
Date: Thu, 21 Nov 2013 11:52:30 -0700
Message-ID: <528E566E.1020704@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com><20131121151218.befbb483c0cf09cdcd4cd4dd@nvidia.com><20131121155649.48C96C406A3@trevor.secretlab.ca>
	<20131121.192051.747601347584525020.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131121.192051.747601347584525020.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/21/2013 10:20 AM, Hiroshi Doyu wrote:
> Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote @ Thu, 21 Nov 2013 16:56:49 +0100:
> 
>> On Thu, 21 Nov 2013 15:12:18 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> On Thu, 21 Nov 2013 13:43:28 +0100
>>> Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>
>>>> On Tue, 19 Nov 2013 11:33:05 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>>> The following pattern of code is tempting:
>>>>>
>>>>>   for (i = 0; !of_parse_phandle_with_args(np, list, cells, i, args); i++)
>>>>>
>>>>> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> That's a very minimal commit message. Can you elaborate please.
>>>
>>> The above can be:
>>>
>>> "
>>>   The following pattern of code is tempting to add a new member for
>>>   of_property_for_each_*() family as an idiom.
>>>   
>>>     for (i = 0;
>>>         !of_parse_phandle_with_args(np, list, cells, i, args); i++)
>>>                   <do something with "args">;
>>> "
>>
>> I really do like commit messages to be full enough that a future reader
>> can figure out why a patch was written. ie:
> 
> Updated as:
> 
>   [PATCHv6+ 01/13] of: introduce of_property_for_earch_phandle_with_args()
>     http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007063.html
> 
> This doesn't depend on anything and this can be merged
> independetly. Thanks for your help.

Well, that patch doesn't depend /on/ anything, but something in the rest
of the series does depend /on it/. As such, this patch can't be merged
completely independently; it has to either:

a) Go into whatever branch the rest of the series goes into.

b) Go into a topic branch in the DT tree, which is then both merged into
the main/regular DT tree /and/ used as a base for the rest of this series.

Dependencies work two ways!

(That is, unless this 1 patch gets merged into 3.14, and the rest of
series doesn't get merged until 3.15. In that case, we can ignore the
dependencies).
